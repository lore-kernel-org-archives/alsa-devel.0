From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 4/8] ALSA: ASoC: DaVinci: i2s, evm,
 pass same value to codec and cpu_dai
Date: Fri, 19 Dec 2008 11:44:42 -0700
Message-ID: <494BEB9A.8080007@boundarydevices.com>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
	<20081219104405.GH24129@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 082B11037EC
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 19:44:49 +0100 (CET)
In-Reply-To: <20081219104405.GH24129@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Dec 18, 2008 at 12:36:42PM -0700, Troy Kisky wrote:
>> Fix the meaning of SND_SOC_DAIFMT_NB_NF to match that
>> used in the codec.
> 
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> I'll hold off on this and the other patches that I didn't apply for now
> until the disagreements have been resolved.
> 

Please drop the remaining patches. I was be sending revised patches
to address my confusion between dsp_a and dsp_b which Jarkko pointed
out.

Thanks
