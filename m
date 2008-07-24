From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Roland/Edirol M-16DX
Date: Wed, 23 Jul 2008 22:38:38 -0400
Message-ID: <9e4733910807231938j732b9031nb0334e3287fc5433@mail.gmail.com>
References: <4887E647.4050406@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id CA9BA248EB
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 04:38:39 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so1509969wra.24
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 19:38:38 -0700 (PDT)
In-Reply-To: <4887E647.4050406@trn.iki.fi>
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
To: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It takes a lot of effort to reverse engineer a device without any
documentation. It would be much easier if you got Roland to give you a
detailed spec on the protocol. Ask their customer support for Linux
drivers. Tell them you'll write a driver if you get the specs and then
send the specs to GregKH's free Linux drivers group.

Once you get a spec it shouldn't be too hard to write a driver unless
they did something really crazy.

Open then box up and look at the chip labels. They could just be
obscuring something that already has a driver by changing the USB
profile.

-- 
Jon Smirl
jonsmirl@gmail.com
