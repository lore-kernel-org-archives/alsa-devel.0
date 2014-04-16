From: Daniel Mack <daniel@zonque.org>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Wed, 16 Apr 2014 10:40:30 +0200
Message-ID: <534E41FE.5010202@zonque.org>
References: <CAEYsuVP4vq+W6ydTyqRtAZ62UOkAFsB87kBv+HnX72rNP+LGeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id BA1F8261A2F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 10:40:31 +0200 (CEST)
In-Reply-To: <CAEYsuVP4vq+W6ydTyqRtAZ62UOkAFsB87kBv+HnX72rNP+LGeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Reyes <dsreyes1014@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 03:44 AM, Andrew Reyes wrote:
> I have a usb Behringer Uphoria UMC204 and it seems to work fine at 44.1khz
> full duplex but anything higher than that I get consistent pops and
> clicks.  I notice it's on the capure side of things as when I have it in
> playback only it's quiet. I have to say I'm testing this using JACK so this
> is how I noticed it on the capture only side of things. I'm not sure
> exactly whats needed to debug this issue. Any help would be appreciated.

Could you send the output of 'lsusb -v', please?


Thanks,
Daniel
