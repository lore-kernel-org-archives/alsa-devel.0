From: Werner Schweer <ws@seh.de>
Subject: Re: bugs in usb midi alsa code?
Date: Wed, 6 Nov 2002 11:52:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211061152.05605.ws@seh.de>
References: <Pine.LNX.4.44.0211051140430.21282-100000@cmn37.stanford.edu>
Reply-To: ws@seh.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from seh.de (betty.seh.de [195.145.22.40])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA26749
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 10:51:07 +0100
Received: from t10 ([192.168.3.19])
	(authenticated bits=0)
	by seh.de (8.12.1/8.12.1) with ESMTP id gA69iZG2028134
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 10:44:36 +0100
In-Reply-To: <Pine.LNX.4.44.0211051140430.21282-100000@cmn37.stanford.edu>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tuesday 05 November 2002 21:22, Fernando Pablo Lopez-Lezcano wrote:
> The MIDI interface I'm using is a Midisport 2x2 (same results with a 1x1).
>
> It works fine with alsa cvs of 2002-08-20, has problems with alsa cvs of
> 2002-10-28.
>
> This is a summary of what I have found so far.
...
> ALSA:
>   input does not seem to work at all. I'm using the Muse MIDI sequencer,
>   with  the older alsa version it works fine (input), with the newer alsa
>   version it does not record midi input at all. Output works fine on both
>   alsa versions.

same on my Roland/Edirol UA100 (audio + 2 midi ports). Midi Input does
not work.

    - Werner






-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
