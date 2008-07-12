From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Date: Sat, 12 Jul 2008 12:14:40 -0600
Message-ID: <fa686aa40807121114u2f7c8ae6p1c1919c713e53c1a@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<20080712180959.GB6523@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A8E2103821
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jul 2008 20:14:41 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so776911and.80
	for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2008 11:14:40 -0700 (PDT)
In-Reply-To: <20080712180959.GB6523@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2008 at 12:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:
>
>> ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
>> v1 API, so I don't expect it to get merged as-is, but I want to get it
>> out there for review.
>
> I've not reviewed this revision of these drivers yet but I just wanted
> to point out that there's absoluely no problem with merging v1 drivers -
> so long as a driver uses the existing merged APIs there's no issue from
> that point of view.

Oops, I forgot to update my commit messages.  I'll probably repost v3
of the series this evening and I'll fix this.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
