import 'package:clean_architechture/core/models/enums/statements.dart';

import '../../generated/assets.dart';

class StatementMap{
  static const Map<Statement, String> paths = {
    Statement.success : Assets.statementsSuccess,
    Statement.failed : Assets.statementsFailed,
    Statement.faceId : Assets.statementsFaceid,
    Statement.warning : Assets.statementsWarning,
    Statement.biometric : Assets.statementsBiometric,
  };
}