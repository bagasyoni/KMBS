import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:akunt/model/model_peg.dart';
import 'package:akunt/view/base_widget/toast.dart';

class PegController with ChangeNotifier {
	
	List data_pegList = new List();

	void selectData(String cari) async {
		data_pegList = await model_peg().data_pegcari(cari);
		notifyListeners();
	}

	//variable tambah peg
	TextEditingController kdpegController = TextEditingController();
	TextEditingController napegController = TextEditingController();
	TextEditingController gajiController = TextEditingController();

	DateTime chooseDate = DateTime.now();
	final format_tanggal = new DateFormat("d-M-y");

	void resetField() {
		kdpegController.clear();
		napegController.clear();
		gajiController.clear();
	}

	Future<bool> tambah_peg() async {
		if (kdpegController.text.isNotEmpty) {
			BotToast.showLoading();
			Map data_insert = new Map();
			data_insert['NO_ID'] = null;
			data_insert['KD_PEG'] = kdpegController.text;
			data_insert['NA_PEG'] = napegController.text;
			data_insert['GAJI'] = gajiController.text;
			await model_peg().insert_data_peg(data_insert);
			Toast("Success !!", "Berhasil menambah barang !!", true);
			BotToast.closeAllLoading();
			return true;
		} else {
			Toast("Peringatan !", "Silahkan isi nama peg !", false);
			return false;
		}
	}

	Future<bool> edit_peg(var id) async {
		if (napegController.text.isNotEmpty) {
			BotToast.showLoading();
			Map data_insert = new Map();
			// chooseDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(id['tanggal']);
			data_insert['NO_ID'] = id;
			data_insert['KD_PEG'] = kdpegController.text;
			data_insert['NA_PEG'] = napegController.text;
			data_insert['GAJI'] = gajiController.text;
			await model_peg().update_data_peg_by_id(data_insert);
			Toast("Success !!", "Berhasil mengedit peg !", true);
			BotToast.closeAllLoading();
			return true;
		} else {
			Toast("Peringatan !", "Silahkan isi nama peg !", false);
			return false;
		}
	}

	Future<bool> hapus_akun(var data) async {
		await model_peg().delete_peg_byID(data['NO_ID'].toString());
		selectData("");
	}

}