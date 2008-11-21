From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/1] [ALSA] ASoc: TLV320AIC23B Cleanup
Date: Thu, 20 Nov 2008 21:48:14 -0700
Message-ID: <49263D8E.5020601@boundarydevices.com>
References: <1226968244-13796-1-git-send-email-troy.kisky@boundarydevices.com>
	<20081118110946.GB23217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 7450824455
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 05:48:22 +0100 (CET)
In-Reply-To: <20081118110946.GB23217@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Nov 17, 2008 at 05:30:44PM -0700, Troy Kisky wrote:
>> Use #ifdef DEBUG to print actual sample rates.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Excellent timing - I did a patch doing pretty much the same thing and
> also fixing some build warnings last night.  Could you please check
> against the for-tiwai branch of:
> 
> 	git://opensource.wolfsonmicro.con/linux-2.6-asoc
> 
> and see if I've missed anything?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

Sorry for the late response. Your version looks fine.

Thanks
Troy
