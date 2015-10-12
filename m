From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Audio Mini Summit 2015, 8th October, Dublin
Date: Mon, 12 Oct 2015 11:11:53 +0200
Message-ID: <561B7959.9090304@metafoo.de>
References: <20151004231752.GA22609@sirena.org.uk>	<20151007152047.GQ12635@sirena.org.uk>	<561679FE.3060809@metafoo.de>	<56167DBF.9090106@metafoo.de>
 <s5hmvvolboe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-070.synserver.de (smtp-out-067.synserver.de
 [212.40.185.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C193260417
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 11:25:32 +0200 (CEST)
In-Reply-To: <s5hmvvolboe.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/12/2015 10:43 AM, Takashi Iwai wrote:
> On Thu, 08 Oct 2015 16:29:19 +0200,
> Lars-Peter Clausen wrote:
>>
>> On 10/08/2015 04:13 PM, Lars-Peter Clausen wrote:
>>> On 10/07/2015 05:20 PM, Mark Brown wrote:
>>>> On Mon, Oct 05, 2015 at 12:17:52AM +0100, Mark Brown wrote:
>>>>> [This message is BCCed to everyone currently on the signup list]
>>>>>
>>>>> As previously announce the audio mini-summit for this year will be this
>>>>> Thursday (8th August) at CCD in Dublin.  Topics we currently have on the
>>>>> list for discussion are:
>>>>
>>>> Current list:
>>>>
>>>>  - Power saving and general system design decisions (is what we're doing
>>>>    lining up with modern hardware with things like multiple output
>>>>    streams?).
>>>>  - Documentation.
>>>>  - alsa-lib releae plans.
>>>>  - What to do with HDMI and its integration with graphics.
>>>>  - Test tools (Intel BAT and others).
>>>>  - BATCH flag.
>>>>  - Fuzz control PCM APIs.
>>>>  - Splitting out root only controls.
>>>>  - ACPI simple-card and general generic card support.
>>>>  - Topology & media controller integration.
>>>>  - Kernel tinification.
>>>>  - Android <-> alsa-lib configuration translation.
>>>>  - HDA restructuring.
>>>>   - Support for DisplayPort MST.
>>>>  - PCM core simplification - the code is currently quite complex!
>>>>  - Soundwire driver support plans.
>>>>  - ASoC multichannel.
>>>>  - Random DAPM changes.
>>>
>>> Media controller:
>>> http://blogs.s-osg.org/working-complicated-problems-media-controller-workshop/
>>
>> And to give some more background information on how the constraints
>> refinement works: http://metafoo.de/alsa_constraints.html
>>
>> It's not yet complete but should still give you and idea
> 
> Any chance to put such a nice material into the official Documentation
> directory?

That's the plan. I started it a while ago, but hadn't had the chance to
finish it yet.
