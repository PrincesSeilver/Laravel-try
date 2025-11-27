@extends('layout')

@section('title', 'Home')

@section('content')
<div class="row">
    <div class="col-md-8 mx-auto">
        <div class="card">
            <div class="card-body text-center">
                <h1>Selamat Datang</h1>
                <p class="lead">Sistem Account Laravel dengan Login & Register</p>
                @auth
                    <p>Anda sudah login sebagai <strong>{{ Auth::user()->name }}</strong></p>
                    <a href="{{ route('dashboard') }}" class="btn btn-primary">Ke Dashboard</a>
                @else
                    <p>Silakan login atau daftar untuk melanjutkan</p>
                    <a href="{{ route('login') }}" class="btn btn-primary me-2">Login</a>
                    <a href="{{ route('register') }}" class="btn btn-success">Register</a>
                @endauth
            </div>
        </div>
    </div>
</div>
@endsection
