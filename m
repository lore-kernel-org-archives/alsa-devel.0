From: CAG <cag@fsk-hh.org>
Subject: M-Delta Audiophile 192 (ice1724) Recording
Date: Mon, 28 Jan 2008 13:29:00 +0100
Message-ID: <479DCA8C.7070209@fsk-hh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nadir.org (mail.nadir.org [217.114.68.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A3DB103843
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 13:30:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: CAG <cag@fsk-hh.org>
List-Id: alsa-devel@alsa-project.org

Hi,

we use the M-Delta Audiophile 192 with alsa-driver-1.0.15 and the 
ice1724 module. Playback works but we cannot record anything.

I noticed that this maybe a bug according to the Alsa Changelog:

 From Changes v1.0.13 v1.0.14:
 >
 >  - ice1724 - Add support of M-Audio Audiophile 192
 >
 >     Added the (experimental) support of M-Audio Audiophile 192 board.
 >     Currently, the analog and the digital playbacks seem working fine.
 >     The inputs seem not working as far as I've tested yet.

How is the status for that card ? Is someone working on this ? I heard 
Recording with OSS works but actually we don't want to switch to OSS...
Is it worth waiting for a new release ?

We desperately need recording!

Cheers from a free radio station,

Toast
