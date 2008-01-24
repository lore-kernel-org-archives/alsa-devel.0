From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] pyalsa sequencer binding - 1/3
Date: Thu, 24 Jan 2008 10:30:59 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801241026430.9698@tm8103.perex-int.cz>
References: <17eedd8a0801080940i14edaef0l2f95e0eb6171cdaf@mail.gmail.com>
	<17eedd8a0801240027u7afa8fecn965957608467c87d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EA5424697
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 10:31:00 +0100 (CET)
In-Reply-To: <17eedd8a0801240027u7afa8fecn965957608467c87d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aldrin Martoq <amartoq@dcc.uchile.cl>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Jan 2008, Aldrin Martoq wrote:

> Hi hackers again,
> 
> I'm sending second PATCH for pyalsa sequencer binding. Major new features:
> - documentation of all python API
> - more info on subscription listing
> - subscribe/unsubscribe
> - events (SeqEvent class)
> - send/receive/modify events
> - creating and managing queues
> 
> I've already ported some existing applications to python versions:
> - aconnect.py
> - aplaymidi.py
> - aseqdump.py
> 
> There are also 3 samples of code seqtest[1-3].py included in the patch.
> 
> 
> 
> It's been a long and tedious work (16 days); please tell me anyhow to
> improve and get this done and finished. Thanks again!!!

Thank you for your work. This patch looks promising. I will review the 
patch today.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
