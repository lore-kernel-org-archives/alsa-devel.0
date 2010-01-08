From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] ALSA: hda - support OLPC XO-1.5 DC
 input
Date: Fri, 8 Jan 2010 09:15:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001080914270.4210@eeebox2.perex-int.cz>
References: <20100107124705.118969D400D@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BD3BA24652
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 09:15:43 +0100 (CET)
In-Reply-To: <20100107124705.118969D400D@zog.reactivated.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <dsd@laptop.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, devel@lists.laptop.org
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Jan 2010, Daniel Drake wrote:

> The XO's audio hardware is wired up to allow DC sensors (e.g. light
> sensors, thermistors, etc) to be plugged in through the microphone jack.
>
> Add sound mixer controls to allow this mode to be enabled and tweaked.

I've applied your patch to my "devel" GIT tree. Thank you. Note: Some your 
comments exceed 80-character line limit.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
