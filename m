From: Timur Tabi <timur@freescale.com>
Subject: Easiest way to test playback on an ASOC driver?
Date: Tue, 03 Jul 2007 18:07:31 -0500
Message-ID: <468AD6B3.2090905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 06DF8103879
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 01:07:34 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l63N7Vqd003795
	for <alsa-devel@alsa-project.org>; Tue, 3 Jul 2007 16:07:32 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l63N7Vff025782
	for <alsa-devel@alsa-project.org>; Tue, 3 Jul 2007 18:07:31 -0500 (CDT)
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
List-Id: alsa-devel@alsa-project.org

I'm in the early stages of testing an ASOC driver, i.e. I'm trying to get playback to work.

What is the easiest way to test playback?  Is there a particular tool I should be using 
that does the most basic and direct playback of audio data through ALSA?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
