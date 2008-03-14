From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: aplay: playback:2021: read error
Date: Fri, 14 Mar 2008 12:05:48 -0700
Message-ID: <61445c750803141205i6d96a5b2o9b8b419050d12a68@mail.gmail.com>
References: <61445c750803131704k2188ffdfp800f757078574fcd@mail.gmail.com>
	<47DA29A6.1060805@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id E17EC1037F5
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 20:05:50 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so4128084wag.8
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 12:05:48 -0700 (PDT)
In-Reply-To: <47DA29A6.1060805@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 14, 2008 at 12:30 AM, Clemens Ladisch <clemens@ladisch.de>
wrote:

> Pharaoh . wrote:
> > aplay: playback:2021: read error
>
> This means that aplay cannot read from the file you're trying to play.
>
>
> HTH
> Clemens
>


It might sound dumb, but I am trying to play a plain raw file, 8 bit mono,
and the file is there on the mounted FS, what could be the reason to fail? I
dont think it is because I am using CRAMFS which is read only.

-pharaoh.
