From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: [PATCH] cm6206: turn off de-emphasis in s/pdif
Date: Tue, 16 Nov 2010 21:43:53 -0300
Message-ID: <AANLkTik6-V2Gv5JCWeSmv_qxETgjpn7nL75UZz74dvJ2@mail.gmail.com>
References: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3881E24378
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 01:43:54 +0100 (CET)
Received: by ewy2 with SMTP id 2so834457ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 16:43:53 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Lammerts <alsa-devel@lists.lammerts.org>
Cc: Dan Allongo <gongo2k1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 16/11/2010, Eric Lammerts <alsa-devel@lists.lammerts.org> wrote:
>
> Hi,
> I just bought a device with a CM6206. Thank you for the quirk that
> made it work out-of-the-box! I noticed on my DAC that the de-emphasis
> LED was on. Is this by accident? Below is a patch (based on the info
> in the CM6206+datasheet+1.7.pdf that I found somewhere) that turns it
> off.
>

Hi all, I have to resubmit some patches for the same chip related to
headphone support. Will you find it useful if I added the de-emphasis
control as a mixer switch?


cheers.


-- 
Adrian.
http://ovejafm.com
http://elesquinazotango.com.ar
