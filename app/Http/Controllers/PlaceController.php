<?php

namespace App\Http\Controllers;

use App\Models\Place;
use Illuminate\Http\Request;

class PlaceController extends Controller{


    public function index(Request $request){
        $places = Place::all();

        return response()->json($places);

    }


}
