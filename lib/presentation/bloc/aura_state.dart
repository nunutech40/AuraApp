import 'package:equatable/equatable.dart';
import '../../domain/entities/aura_entity.dart';

abstract class AuraState extends Equatable {
  const AuraState();

  @override
  List<Object?> get props => [];
}

class AuraInitial extends AuraState {}

class AuraScanning extends AuraState {}

class AuraSuccess extends AuraState {
  final List<AuraEntity> results;

  const AuraSuccess(this.results);

  @override
  List<Object?> get props => [results];
}

class AuraError extends AuraState {
  final String message;

  const AuraError(this.message);

  @override
  List<Object?> get props => [message];
}
