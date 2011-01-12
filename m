From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 16:53:20 +0800
Message-ID: <AANLkTinBnEj8570w96cy0CQ6+TmzrvTu6uBZQegs10CP@mail.gmail.com>
References: <igi861$q8o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DCFA424466
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 09:53:20 +0100 (CET)
Received: by eyg24 with SMTP id 24so113713eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 00:53:20 -0800 (PST)
In-Reply-To: <igi861$q8o$1@dough.gmane.org>
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

2011/1/12 Colin Guthrie <gmane@colin.guthr.ie>

> Hi,
>
> As has been pointed out a few times, it's incorrect to use "front:" for
> capture, but can we have an official name/wrapper (I'm unsure of the
> terminology here) for this so we don't use hw: for recording?
>
>
My sb live! platinum when using "mono profile" which use  "hw:0" does not
output any sound

it seem that emu10k1 have to use "front:0" for playing mono
