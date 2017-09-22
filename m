From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [Resend] [PATCH v1 3/4] ASoC: dapm: Avoid creating
	kcontrol for params
Date: Fri, 22 Sep 2017 09:16:32 -0700
Message-ID: <4EAA9E0A-ED25-4BDC-AB53-E33C844FAB43@gmail.com>
References: <1506066940-56758-1-git-send-email-yesanishhere@gmail.com>
 <20170922091921.kpl4r3fuutgaoizw@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 74842266B7E
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 18:16:37 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id i130so886650pgc.0
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 09:16:36 -0700 (PDT)
In-Reply-To: <20170922091921.kpl4r3fuutgaoizw@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



> On Sep 22, 2017, at 2:19 AM, Mark Brown <broonie@kernel.org> wrote:
> 
>> On Fri, Sep 22, 2017 at 12:55:40AM -0700, yesanishhere@gmail.com wrote:
>> From: anish kumar <yesanishhere@gmail.com>
>> 
>> Currently in codec to codec dai link if there are multiple
>> params defined then dapm can use created kcontrol to
>> decide which param to apply at runtime.
> 
> You've sent me patch 3/4 and only patch 3/4.

Other patches are already reviewed by Charles and he had comment for 3/4 patch so I sent only that.
>  What's going on with the
> other three patches?  Please remember that the entire purpose of
> numbering patches is to order them in a series, if you're not sending a
> series there's no need to number things and if

Got it. Will keep that in mind for future.
> you're sending a series
> the numbering should reflect what you're sending now, not any previous
> versions of the patches.
