From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [FFADO-devel] [RFC v3] [PATCH 00/52] Enhancement
 for support of firewire devices
Date: Fri, 21 Feb 2014 21:39:34 +0100
Message-ID: <20140221213934.1bfe5415@stein>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
 <20140221165444.GA25817@redhat.com> <20140221212804.061e8b30@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id E99C52607BB
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 21:39:37 +0100 (CET)
In-Reply-To: <20140221212804.061e8b30@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jay Fenlason <fenlason@redhat.com>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Feb 21 Stefan Richter wrote:
> On Feb 21 Jay Fenlason wrote:
> > I could not play audio through the FireWave (either directly via aplay
> > or through PulseAudio).  This is a regression from the fwspkr driver,
> > which worked on this machine.
> 
> Did you apply this patch series, or pull from git?
> (https://github.com/takaswie/snd-firewire-improve)
> Griffin FireWave and Lacie Speakers need this here:
> https://github.com/takaswie/snd-firewire-improve/commit/fae91361062fca5491ec54baddd6f009e57703f5
> (Haven't arranged to pull and test myself yet.)

Hmm, no, the fix which I had in mind came long before this and is
apparently already present in the v3 postings.  Sorry,
-- 
Stefan Richter
-=====-====- --=- =-=-=
http://arcgraph.de/sr/
