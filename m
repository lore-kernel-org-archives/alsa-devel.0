From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: About TASCAM US-122 mkII support
Date: Mon, 7 Dec 2009 18:04:05 +0100
Message-ID: <200912071804.06126.fzu@wemgehoertderstaat.de>
References: <4B1D302B.5040002@physik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	by alsa0.perex.cz (Postfix) with ESMTP id DA50124508
	for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2009 18:04:11 +0100 (CET)
In-Reply-To: <4B1D302B.5040002@physik.uni-hamburg.de>
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
Cc: delaossa@mail.desy.de, Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
List-Id: alsa-devel@alsa-project.org

Am Montag 07 Dezember 2009 schrieb Tobias Hansen:
> 
> I know that the US-144 MKII has a different Product ID (8020) than the US-144 (800F), so the US-122 MKII probably also has another one than the US-122L. If you post your output of lsusb with the device plugged in, I could make a patch that adds these both IDs to the us122l driver for testing if that suffices.
> 

Hi Tobias,

Gabriel already posted the US-122 mkII's id:

	ID 0644:8021 TEAC Corp.

Thanks,
Karsten
