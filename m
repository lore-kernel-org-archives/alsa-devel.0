From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [RESEND PATCH v2] ASoC: SOF: Intel: hda: Make
 hdac_device device-managed
Date: Mon, 15 Jul 2019 13:05:15 -0700
Message-ID: <243bf2494a73284addfdd2b5c46d3ae89ec7cfcd.camel@linux.intel.com>
References: <20190707235633.7114-1-ranjani.sridharan@linux.intel.com>
 <7fc6fdf3461c8faff4d853f80e282f3830a04724.camel@linux.intel.com>
 <20190715193525.GB4503@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DC99F800C6
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 22:05:27 +0200 (CEST)
In-Reply-To: <20190715193525.GB4503@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2019-07-15 at 20:35 +0100, Mark Brown wrote:
> On Mon, Jul 15, 2019 at 08:27:55AM -0700, Ranjani Sridharan wrote:
> 
> > This patch is needed for the module load/unload stress tests for
> > the
> > Intel platforms with SOF. Could you please help review it?
> 
> Please don't send content free pings and please allow a reasonable
> time
> for review.  People get busy, go on holiday, attend conferences and
> so 
> on so unless there is some reason for urgency (like critical bug
> fixes)
> please allow at least a couple of weeks for review.  If there have
> been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen
> at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the
> patches
> anyway, so sending again is generally a better approach though there
> are
> some other maintainers who like them - if in doubt look at how
> patches
> for the subsystem are normally handled.
Understood, sorry for the noise. I just wasn't sure about what the
reasonable response time to expect was. I will check back in a week's
time.

Thanks,
Ranjani
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
