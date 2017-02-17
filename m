From: "amidi@LEFerguson.com" <amidi@LEFerguson.com>
Subject: Re: Help with midi player application
Date: Fri, 17 Feb 2017 17:11:35 +0000
Message-ID: <BN6PR05MB30093227CF6FB0511D20CE56D55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
References: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
 <4c95ab4d-55a8-bbc7-f758-7022ab800440@ladisch.de>
 <BN6PR05MB3009240F07BF616C635EA8ABD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
 <010aad38-9842-7aad-f8b3-3956a76ec8ef@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0137.outbound.protection.outlook.com [104.47.33.137])
 by alsa0.perex.cz (Postfix) with ESMTP id CBA812671DB
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 18:11:37 +0100 (CET)
In-Reply-To: <010aad38-9842-7aad-f8b3-3956a76ec8ef@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>amidi@LEFerguson.com wrote:
>> I took the technique from what pmidi did
>
>AFAICS pmidi uses absolute timestamps.

Hmmm.... Starting to doubt my memory now... I see it does use a 0 in that parameter.  Not sure where I got using relative.  Let me go back and review.  Maybe I am scheduling the math incorrectly.

Thank you for emphasizing that.  I could have sworn I copied it from pmidi, but I must have changed at some point for some reason.  Need to rethink it.

More to follow...

Linwood
