<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Link extends Model
{
    protected $fillable = ['key', 'url'];

    public function getShortUrl()
    {
        return route('short.redirect', [
            'key' => $this->key
        ]);
    }
}
