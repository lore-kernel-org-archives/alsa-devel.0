From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: iMac 9,1 sound patch
Date: Thu, 2 Apr 2009 13:01:18 -0700
Message-ID: <dd18b0c30904021301y4aaca17er575aa1ba58069d81@mail.gmail.com>
References: <e40c6ffa0904021030u701701c8w1f1ec65be007ecb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 34ECB1037F3
	for <Alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 22:01:19 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so546333qwf.56
	for <Alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 13:01:18 -0700 (PDT)
In-Reply-To: <e40c6ffa0904021030u701701c8w1f1ec65be007ecb2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Micah Bucy <micah.bucy@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/4/2 Micah Bucy <micah.bucy@gmail.com>:
> I tried a git snapshot, but it wasn't working at all, so this patch was
> developed against the 1.0.19 stable release.
>
> This is my first time delving into alsa, so I'm not sure if everything is
> how it should be, including if the patch was correctly created. =A0I can =
tell
> you this. =A0I was able to get jack detection working correctly as long a=
s the
> 6 channel option is set. =A0I had tried modifying it to only allow a 6ch
> option as 2ch is for line-out (headphones) only, but the internal speakers
> wouldn't work, so I left it alone. =A0My guess is, this same setup could =
be
> used by the macbook pro 5,1 =A0I'll give it a try over the weekend. =A0I =
have
> not tested the built-in mic or the line-in.
>
> -Micah
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>

will this work on the new imac, or
is it something with nvidia?

-- =

Justin P. Mattock
