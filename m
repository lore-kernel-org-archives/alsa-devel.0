From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Status of Midiman Midisport 8x8 Interface Driver
Date: Wed, 08 May 2002 10:06:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD8DC81.16E3DAEE@ladisch.de>
References: <B3E252A41984D411BF68009027E5CE97032BE03E@exchange-ms01.piro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA02732
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 10:06:27 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joachim Backhaus <jbackhaus@pironet-ndh.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joachim Backhaus wrote:
> what is the current status of the development
> of the Midiman Midisport 8x8 Interface Drivers?

The Midisport XxX interfaces need a firmware upload to work properly.
Firmware for the Midisport 1x1 is included with the OSS USB MIDI driver
<http://member.nifty.ne.jp/Breeze/softwares/unix/usbmidi-e.html>.
Firmware for the 8x8 doesn't exist (yet), but the docs contain some
hints on how to write one.


Clemens

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
