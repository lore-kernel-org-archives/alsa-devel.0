From: Timo Wischer <twischer@de.adit-jv.com>
Subject: Re: HTTP GIT access to alsa-lib seems to be misaligned
Date: Wed, 14 Nov 2018 09:42:31 +0100
Message-ID: <5938cd3f-b4b5-c298-9615-c52e64aff3ec@de.adit-jv.com>
References: <d0499705-8b84-3761-42f0-f4b3b311c6d0@de.adit-jv.com>
 <s5hpnv8c25i.wl-tiwai@suse.de>
 <3ec40b00-2781-a205-dd14-4e8742a2921b@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E782267839
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 09:42:38 +0100 (CET)
In-Reply-To: <3ec40b00-2781-a205-dd14-4e8742a2921b@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now, it is working fine again.

Thanks.

Best regards
*Timo Wischer*
Engineering Software Base (ADITG/ESB)

Tel. +49 5121 49 6938
On 11/13/18 23:05, Jaroslav Kysela wrote:
> Dne 13.11.2018 v 18:34 Takashi Iwai napsal(a):
>> On Tue, 13 Nov 2018 11:26:18 +0100,
>> Timo Wischer wrote:
>>> Hi all,
>>>
>>> The master branch of
>>>
>>> $ git clone http://git.alsa-project.org/http/alsa-lib.git
>> I don't think http never worked properly for git.alsa-project.org.
> It should work. The http export should be properly updated.
>
> 					Jaroslav
>
