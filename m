From: Guilherme <grlongo.ireland@gmail.com>
Subject: Understanding _snd_pcm_channel_area Struct (PCM
	Interface)!
Date: Tue, 23 Jun 2009 02:40:35 -0300
Message-ID: <4A406AD3.2050002@gmail.com>
References: <4A3DEAF9.80508@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id CD18524541
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 07:39:28 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so1891738qwj.56
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 22:39:27 -0700 (PDT)
In-Reply-To: <4A3DEAF9.80508@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all.

I am a bit confused on what I get with this function.
I finished my first project but I did not understand what exactly the

_snd_pcm_channel_area at

 http://www.alsa-project.org/alsa-doc/alsa-lib/struct__snd__pcm__channel__a=
rea.html

does.

There are 3 fields in the documentation.

addr, first and step.

It seems that addr is the memory address of the channel samples... so =

far so good. The "step" is the distance between 2 sample (but I am not =

sure) and the least, "first", I could not figure out what does it means.

Could I get some help from here?
 =

Thanks in advanced!

Tks!

-------------------

Guilherme Longo
Dept. Eng. da Computa=E7=E3o
Unaerp

Linux User - #484927

*Before Asking
http://www.istf.com.br/?page=3Dperguntas

!- I'd rather die on my feet than live on my knees -!
