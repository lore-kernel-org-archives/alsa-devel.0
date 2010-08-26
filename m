From: Keith Chew <keith.chew@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 19:22:48 +1200
Message-ID: <AANLkTi=pv2aH0tyH-JVfNhg8v4M6aOxcoCP-20qfvfLq@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
	<AANLkTinDrAurZxUzSBo2pqrTKo13d+msLFvjva-+=5ET@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FB2D10380E
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 09:22:49 +0200 (CEST)
Received: by iwn4 with SMTP id 4so1327918iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 00:22:48 -0700 (PDT)
In-Reply-To: <AANLkTinDrAurZxUzSBo2pqrTKo13d+msLFvjva-+=5ET@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> The easy way is try those [ALC888_xxx]
> models with alc88x_3st_6ch_mixer

Hi Raymond

I have gone through patch_realtek and none of them are retasking the
mic2 and line2 to get 5.1 surround sound. Will try David's suggestion,
I think that will work.

Regards
Keith
