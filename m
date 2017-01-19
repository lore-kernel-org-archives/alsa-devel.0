From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v4 1/3] DRM: add help to get ELD speaker
	allocation
Date: Thu, 19 Jan 2017 11:49:56 +0100
Message-ID: <12dd4fb5-978d-f479-208b-1c57ade16e38@st.com>
References: <1483458772-13658-1-git-send-email-arnaud.pouliquen@st.com>
 <1483458772-13658-2-git-send-email-arnaud.pouliquen@st.com>
 <20170117191902.zugqcnb4osxmcgaj@sirena.org.uk>
 <87bmv5wheq.fsf@eliezer.anholt.net>
 <20170119102901.h35ynrcztf5z7vb3@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D23C12669C8
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 11:49:59 +0100 (CET)
In-Reply-To: <20170119102901.h35ynrcztf5z7vb3@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Jani Nikula <jani.nikula@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org



On 01/19/2017 11:29 AM, Mark Brown wrote:
> On Wed, Jan 18, 2017 at 07:38:53AM +1100, Eric Anholt wrote:
>> Mark Brown <broonie@kernel.org> writes:
> 
>>> You don't appear to have sent this to any of the DRM
>>> maintainers - it does need review from them.
> 
>> It was sent to dri-devel.  That's us.  And the patch already has
>> a r-b From DRM on it.
> 
> I see.  For most subsystems you need to actually copy a human to
> make sure that things are seen - just the list isn't enough.  In
> terms of it being reviewed one of the problems with DRM not listing
> the reviwers in the MAINTAINERS file or anything is that it's very
> hard for anyone to tell if something is considered a good enough
> review or if it's just a review from someone who happens to
> contribute to DRM sometimes.
> 
I limited diffusion to ASoC, as Daniel Vetter and Takashi Iwai
discussed the topic here:
http://www.spinics.net/lists/alsa-devel/msg58114.html
Seems that is was not a good strategy as it leads to discussions..
Sorry for this.

Regards
Arnaud
