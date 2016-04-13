From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: SPDIF trouble with multiple usb devices
Date: Wed, 13 Apr 2016 11:30:27 +0200
Message-ID: <alpine.DEB.2.02.1604131128080.9999@lnxricardw1.se.axis.com>
References: <570D7676.1060004@ponzo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 56AFF2604D6
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 11:30:36 +0200 (CEST)
In-Reply-To: <570D7676.1060004@ponzo.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Doty <scott@ponzo.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, 13 Apr 2016, Scott Doty wrote:

> So I'm having the worst luck with optical SPDIF devices.
>  ...
> =

>  3 [HD             ]: USB-Audio - USB Sound Blaster HD
>                       Creative Technology USB Sound Blaster HD at
> usb-0000:00:14.0-4.7.6, full speed
> =

> I used to be able to use the optical SPDIF input for this device from my
> synth, but that seems to have stopped working.  Further, I can't play
> audio out of the Sound Blaster HD's optical SPDIF output, either.  It
> works in Windows 10, which is where I had to spend my latest music
> session -- yuck.

Exactly what does 'stopped working' mean? Doesn't it should up when you =

enumerate audio devices, does it show up but input and output results in =

silence, does it show up but attempting to send audio results in an error, =

etc. (I know you linked to a long ALSA dump, but folks around here would =

be more willing to help if you stated as precisely as you could which =

symptoms you actually have.)

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
