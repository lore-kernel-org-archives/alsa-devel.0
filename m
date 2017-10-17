From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: HDMI LPE audio on Intel Compute Stick 2nd Gen (CHT)
Date: Tue, 17 Oct 2017 08:55:14 -0500
Message-ID: <7827e954-d9d0-4737-5e47-13e0e69fd92d@linux.intel.com>
References: <CAFXWsS_V=nG8C+NM8qmtjdoZoWrsTnTFNR16kU05NNsx=c0-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EAB7266DA4
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 15:55:18 +0200 (CEST)
In-Reply-To: <CAFXWsS_V=nG8C+NM8qmtjdoZoWrsTnTFNR16kU05NNsx=c0-5Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/17/17 5:50 AM, Ian W MORRISON wrote:
> Hi Pierre,
> 
> I've just noticed that non of the kernels from v4.13 and up run on my
> Intel Compute Stick (2nd gen Cherry Trail STK1AW32SC) unit and have
> HDMI LPE audio working. Before I spend anytime looking into this can
> you confirm if you have the same issue as I just want to rule out a
> hardware malfunction with my unit first?

I have not tested HDMI in a while but I am not aware of any issues 
either. There were some patches recently to fix PulseAudio problems and 
I suppose some folks used a recent kernel?
