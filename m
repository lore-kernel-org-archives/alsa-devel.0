From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: When will Realtek High-Defintion audio codec
 ALC282 be supported?
Date: Fri, 13 Jul 2012 07:01:32 +0200
Message-ID: <4FFFABAC.8010408@canonical.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F81560FB@SHSMSX101.ccr.corp.intel.com>
	<F46914AEC2663F4A9BB62374E5EEF8F81561B7@SHSMSX101.ccr.corp.intel.com>
	<4FFE6FAA.8070209@canonical.com>
	<F46914AEC2663F4A9BB62374E5EEF8F81564B4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id BB5D62458A
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2012 07:01:34 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F81564B4@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/13/2012 02:43 AM, Lin, Mengdong wrote:
> Hi David,
>
>> { .id = 0x10ec0282, .name = "ALC282", .patch = patch_alc269 },
>>
>> But I don't think Takashi would add such a line to the kernel without
>> somebody testing that it actually works.
>> If you have the hardware available, you can try the above line, see if it
>> works, and report back together with alsa-info for the affected system.
>
> Many thanks! I'll try it when the hardware is available.
> BTW, do you have ALC282 datasheet? If yes, could you share the datasheet with me for a reference?

No, I don't have a datasheet or any other information about the ALC282.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
