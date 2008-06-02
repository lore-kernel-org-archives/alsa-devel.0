From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: power save of snd_hda_intel
Date: Mon, 2 Jun 2008 11:05:54 +0530
Message-ID: <827ad74d0806012235x48dd5833iefbf314f0b4bd5df@mail.gmail.com>
References: <827ad74d0805280609p8420727gcf08dd557a52ae5a@mail.gmail.com>
	<483D84E7.2040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 271AA24599
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 07:35:56 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so232784and.80
	for <alsa-devel@alsa-project.org>; Sun, 01 Jun 2008 22:35:55 -0700 (PDT)
In-Reply-To: <483D84E7.2040409@gmail.com>
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
To: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I checked on these articles...i manually set it the value to 10 but still
dont see any power saving...

has anyone tried this before and seen any power saving?

please help me with more clues...

On Wed, May 28, 2008 at 9:44 PM, Chris Pemberton <
cjpembo.mailing.lists@gmail.com> wrote:

> Harsha priya gupta wrote:
>
>> Hi,
>>
>> I am trying to get a power_save option of snd_hda_intel working.
>> We are using latest ALSA build and ALC262 codec. when we start the player
>> and close it, we dont see any power savings. [ We see the power saving in
>> windows with the same ALC262 card]
>>
>> Any idea what i could be doing wrong here?
>>
>>
>>
> powertop is your friend
>
> www.lesswatts.org
>
> specifically:
>
> http://www.lesswatts.org/tips/misc.php
>
> Chris
>



-- 
-Harsha
