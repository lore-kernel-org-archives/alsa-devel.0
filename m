From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: Re: [ANNOUNCE] 2018 Linux Audio miniconference
Date: Sun, 26 Aug 2018 20:33:21 +0200
Message-ID: <b735609d-e160-0e48-de6a-a6b36369b7e3@iot.bzh>
References: <20180810110656.GE20971@sirena.org.uk>
 <20180816160233.GA5656@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 043BD267668
 for <alsa-devel@alsa-project.org>; Sun, 26 Aug 2018 20:33:24 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id j26-v6so11596532wre.2
 for <alsa-devel@alsa-project.org>; Sun, 26 Aug 2018 11:33:24 -0700 (PDT)
In-Reply-To: <20180816160233.GA5656@sirena.org.uk>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Mark,

If the room is not already fully pack, I would love to send/two guys 
from my team to this ALSA F2F@ELC.

My team is the main maintainer for the 4A(AGL Advance Audio 
Architecture) AGL(Automotive Grade Linux) that relies on raw ALSA.

While AGL/4A obviously target the automotive market, most of the 
concepts should be valuable in other embedded projects that require 
advanced audio config (role, zone, policies/security, docking, mixing, 
...) with limited CPU/RAM resources.

Current hot topic for automotive:
  - smart/smooth integration of soft/hard DSP for equalisation/mixing
  - noise cancellation and sound bubble (for speech recognition)
  - sound synchronous networks
  - virtualisation

Fulup

ps: AGL/4A presentation at 
https://iot.bzh/download/public/2018/amm-tokyo/AGL-Audio-Advanced-Architecture.pdf


On 16/08/18 18:02, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 12:06:56PM +0100, Mark Brown wrote:
>> As in previous years we're trying to organize an audio miniconference so
>> we can get together and talk through issues, especially design decisons,
>> face to face.  This year's event will be held on Sunday October 21st in
>> Edinburgh, the day before ELC Europe starts there.  We're still
>> finalizing the venue (we expect to be able to confirm next week) but
>> it'll be outside the ELC venue so there will be no need to purchase an
>> ELC ticket to attend.
> 
> I am pleased to be able to confirm that Cirrus Logic have generously
> offered to host this at their offices in Edinburgh:
> 
> 	7B Nightingale Way
> 	Quartermile
> 	Edinburgh
> 	EH3 9EG
> 
> (this is very central, quite near the ELC/Open Source Summit venue.)
> 
>> As with previous years let's pull together an agenda through a mailinghttps://www.google.com/search?q=lenohttps://www.google.com/search?q=lenovo+X250+adding+disk&ie=utf-8&oe=utf-8&client=firefox-bhttps://www.google.com/search?q=lenovo+X250+adding+disk&ie=utf-8&oe=utf-8&client=firefox-bvo+X250+adding+disk&ie=utf-8&oe=utf-8&client=firefox-b
>> list discussion - if people could reply to this mail with any topics
>> they'd like to discuss we can take it from there.  Of course if we can
>> sort things out more quickly via the mailing list that's even better!
> 
> Not much discussion yet - one topic I think there's some useful
> discussion to be had about is DSPs, we've got the recent Intel work with
> Sound Open Firmware opening things up there and potentially being able
> to offload work from the userspace sound servers.
> 
>> If you're planning to attend please fill out the form here:
>>
>>    https://docs.google.com/spreadsheets/d/11p2pSNxS7sJysg1JwErWi0T2Dq7XKRtAGngBHAn_w2g/edit?usp=sharing
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
