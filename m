From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Fix 0 dB offset for HP laptops
	using CX20551 (Waikiki)
Date: Mon, 22 Mar 2010 11:02:57 +0800
Message-ID: <4f3252891003212002y3de65f75xe84239e5d1458f56@mail.gmail.com>
References: <604760771003211601n3457e1d5jcff90aacefdcd112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5EC292450A
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 04:02:58 +0100 (CET)
Received: by pwj7 with SMTP id 7so3212457pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Mar 2010 20:02:57 -0700 (PDT)
In-Reply-To: <604760771003211601n3457e1d5jcff90aacefdcd112@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/3/22 Daniel Chen <seven.steps@gmail.com>

> Hi,
>
> Attached is a patch to fix distortion at max PCM setting for HP
> laptops using CX20551 (Waikiki).
>
> Best,
> -Dan
>
>
how did he verifty the 0dB ? using hw device or pulseaudio
