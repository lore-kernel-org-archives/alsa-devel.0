From: Olaf Hering <olaf@aepfle.de>
Subject: Re: hdmi audio on Shuttle XS35GS V3L
Date: Fri, 20 Sep 2013 15:54:46 +0200
Message-ID: <20130920135446.GA29307@aepfle.de>
References: <20130919142333.GA29383@aepfle.de>
 <20130920122546.GA9628@aepfle.de> <523C481F.8050703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 62A1E26569A
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 15:54:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <523C481F.8050703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 20, Clemens Ladisch wrote:

> Olaf Hering wrote:
> > Does anyone happen to know if HDMI audio is supposed to work on the
> > Shuttle XS35GS V3L? I have tried an AOC E2260Pwhu monitor and also a
> > Philips 22PFL3805H/12 TV, both show the picture but no sound is played
> > via HDMI.
> >
> > ==> /proc/asound/card0/eld#1.0 <==
> > monitor_present         0
> > eld_valid               0
> 
> > ==> /proc/asound/card1/eld#0.0 <==
> > monitor_present         0
> > eld_valid               0
> 
> Is this with some monitor present?

Yes, the AOC monitor is connected to the Shuttle with an HDMI cable (EAN
4043718042692, if that matters).

The speaker in the AOC is working when I use an audio cable and a VGA
cable. But I was hoping to need just one cable to carry both audio and
video.

Olaf
