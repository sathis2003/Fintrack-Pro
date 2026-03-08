import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/premium_bloc.dart';
import '../bloc/premium_event.dart';
import '../bloc/premium_state.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinTrack Pro Premium'),
        elevation: 0,
      ),
      body: BlocConsumer<PremiumBloc, PremiumState>(
        listener: (context, state) {
          if (state is PremiumSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Welcome to Pro!'),
                  backgroundColor: Colors.green),
            );
            context.pop();
          }
          if (state is PremiumError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is PremiumLoading || state is PremiumInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PremiumOfferingsLoaded) {
            return _buildPaywall(context, state);
          }

          if (state is PremiumStatusLoaded) {
            if (state.isPro) {
              return const Center(
                  child: Text('You are already a Pro member! 🎉'));
            }
            context.read<PremiumBloc>().add(PremiumFetchOfferings());
            return const Center(child: CircularProgressIndicator());
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPaywall(BuildContext context, PremiumOfferingsLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.star, size: 80, color: Colors.amber),
          const SizedBox(height: 16),
          const Text(
            'Go Pro',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Unlock the full power of FinTrack Pro',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _buildFeatureRow(Icons.auto_graph, 'Unlimited AI Reports'),
          _buildFeatureRow(Icons.cloud_upload, 'Priority Cloud Sync'),
          _buildFeatureRow(Icons.category, 'Custom Categories'),
          _buildFeatureRow(Icons.security, 'Advanced Biometric Lock'),
          const SizedBox(height: 48),
          if (state.packages.isEmpty)
            const Text('No plans currently available.')
          else
            ...state.packages
                .map((package) => _buildPackageCard(context, package)),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () =>
                context.read<PremiumBloc>().add(PremiumRestoreRequested()),
            child: const Text('Restore Purchases'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0F3460)),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, dynamic package) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () =>
            context.read<PremiumBloc>().add(PremiumPurchaseRequested(package)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.storeProduct.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    package.storeProduct.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                package.storeProduct.priceString,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F3460)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
