From: "Arun KS" <getarunks@gmail.com>
Subject: Re: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 17:21:48 +0530
Message-ID: <dfeb90390811200351t20a43ecfp39705234e0bce180@mail.gmail.com>
References: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
	<20081120112304.GB4539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id B957824330
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 12:51:50 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id j3so244844tid.8
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 03:51:48 -0800 (PST)
In-Reply-To: <20081120112304.GB4539@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: naveen krishna ch <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 4:53 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Nov 20, 2008 at 04:49:33PM +0530, naveen krishna ch wrote:
>
>> [PATCH] Register default values for gain, path selection for various input
>> and output devices
>> From:
>> chnaveenkrishna <chnaveen@chnaveen.mistral.in>
>>   To:
>> Date:
>> Today 04:49:50 pm
>
> Something (your MUA)?  Is mangling this really badly...
>
> As I said in reply to your first mail I'd really like to see some sort
> of explanation as to why you are making these changes - are the defaults
> in the existing driver wrong?  There seem to be an awful lot of changes
> here and there's no discussion in the patch as to what they mean.
Hi Mark,

By 'defaults' did you mean the reset values of the codec registers?

Arun

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
