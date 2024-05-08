import 'package:license/model/instructor_model.dart';
import 'package:license/res/types.dart';

class InstructorSelectionViewModel {
  final InstructorModel _selectInstructorModel = InstructorModel();

  Future<List<Instructor>> getInstructors() async {
    try {
      return await _selectInstructorModel.getInstructors();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Instructor> getInstructor(String id) async {
    try {
      return await _selectInstructorModel.getInstructor(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
