<?php

namespace App\Http\Controllers;

use App\Http\Requests\ShortnerLinkRequest;
use App\Link;
use App\Log;
use Illuminate\Support\Str;

class ShortnerController extends Controller
{
    public function redirect(string $key)
    {
        $link = Link::where('key', '=', $key)
            ->first();

        if (!$link) {
            return response('', 400);
        }

        Log::create(['link_id' => $link->id]);
        return redirect($link->url);
    }

    public function link(ShortnerLinkRequest $request)
    {
        if (!$request->ajax()) {
            return response('', 400);
        }

        $url = $request->input('url');

        $link = Link::where('url', '=', $url)
            ->first();

        if (!$link) {
            $key = Str::random(10);
            $link = Link::create([
                'key' => $key,
                'url' => $url
            ]);
        }

        return response()
            ->json([
                'data' => $link->getShortUrl()
            ]);
    }
}
