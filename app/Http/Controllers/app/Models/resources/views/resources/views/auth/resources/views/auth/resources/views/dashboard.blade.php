@extends('layout')

@section('title', 'Dashboard')

@section('content')
<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">Dashboard</div>
            <div class="card-body">
                <h5>Selamat datang, {{ Auth::user()->name }}!</h5>
                <p><strong>Email:</strong> {{ Auth::user()->email }}</p>
                <p><strong>Bergabung sejak:</strong> {{ Auth::user()->created_at->format('d M Y') }}</p>
                <p>Akun Anda sudah aktif dan siap digunakan.</p>
            </div>
        </div>
    </div>
</div>
@endsection
