From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Mon, 19 Oct 2015 23:21:09 +0900
Message-ID: <5624FC55.8000100@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant> <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp> <20151013100228.GA16452@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 273F1265CB5
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 16:21:13 +0200 (CEST)
In-Reply-To: <20151013100228.GA16452@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

On Oct 13 2015 19:02, Jonathan Woithe wrote:
>> I'm glad to get your help for these issues, Stefan and Jonathan.
> 
> Now that there is functional infrastructure within ALSA to build on I am
> hoping to start experimenting with RME and MOTU devices over the next few
> months by porting my FFADO streaming drivers to ALSA.

This year I got some supports (not commercial) from Japan office of
Synthax Inc. They lent some RME models to me. At the beginning of audio
and music unit on IEEE 1394 bus, I'll borrow FireFace 400 and start to
develop for ALSA RME driver, next month.

Currently, ALSA MOTU driver is under working in my repository, so it's
better to start your development for it.


Thanks

Takashi Sakamoto
