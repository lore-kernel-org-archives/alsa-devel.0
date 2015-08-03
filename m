From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Mon, 3 Aug 2015 08:45:52 +0530
Message-ID: <20150803031552.GN29916@localhost>
References: <20150714150352.GW11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108CC68@RTITMBSV03.realtek.com.tw>
 <55B6B92B.5010305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5999B26262A
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 05:14:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55B6B92B.5010305@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 27, 2015 at 06:05:15PM -0500, Pierre-Louis Bossart wrote:
> On 7/21/15 6:29 AM, Bard Liao wrote:
> >>-----Original Message-----
> >>From: Mark Brown [mailto:broonie@kernel.org]
> >>Sent: Tuesday, July 14, 2015 11:04 PM
> >>To: Takashi Iwai; Liam Girdwood; Jaroslav Kysela
> >>Cc: alsa-devel@alsa-project.org
> >>Subject: [REANNOUNCE] Audio Mini Summit 2015, 8th October, Dublin
> >>
> >>Like previous years, we're going to hold a meeting to discuss lowlevel
> >>audio on Linux.  This will be held the day after ELC Europe on 8th
> >>October at CCD (The Convention Centre) in Dublin.
> >>
> >>If you're interested please sign up in the attendee list:
> >>
> >>https://docs.google.com/spreadsheets/d/1bi-8GHsqlzt41FR20WiMuWILe_
> >>cZowFireVMBd-QM8Q/edit?usp=sharing
> >>
> >>and please follow up to this mail with any topics you'd like to see raised so
> >>we can start collecting them (probably another Google doc will be
> >>forthcoming for them).
> >>
> >>Previously suggested topics include:
> >>
> >>  - Reducing kernel size for IoT applications
> >>  - ACPI simple-card
> 
> I think we should also share findings on DeviceTree vs. ACPI support
> for machine drivers and subnodes.

I am planning to discuss two things in this space:
- One the NHLT table in BIOS
- Second my ongoing work on ACPI properties for machines, hopefully should be
  able to send patches before conference

-- 
~Vinod
