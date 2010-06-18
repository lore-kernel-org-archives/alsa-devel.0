From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: Cannot find
Date: Fri, 18 Jun 2010 19:33:12 +0900
Message-ID: <4C1B4B68.3040508@samsung.com>
References: <AANLkTimoL84XqLSBwWbIs8Krzp-HpHmIU45GRGv4CyIr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id AA51F103963
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 12:33:14 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L4700GP6HBBCD30@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 18 Jun 2010 19:33:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L4700BDIHBBTE@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 18 Jun 2010 19:33:11 +0900 (KST)
In-reply-to: <AANLkTimoL84XqLSBwWbIs8Krzp-HpHmIU45GRGv4CyIr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: subapriya sakthivel <subapriya.sakthi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/18/2010 7:23 PM, subapriya sakthivel wrote:
> Hay guys,
> 
> I have download eclair branch code using below commands.
> 
> repo init -u git://android.git.kernel.org/platform/manifest.git -b eclair
> repo sync
> 
> But inside Hardware folder, i cannot find alsa_sound folder.
> 
> Can anyone help me on this?
> 

The alsa_sound isn't the default repository of android repo init.
You should do directly 'git clone' it.

> Am i chekout from correct branch?
> If so, where can i get this folder.
> 
> Thanks for your help in advance.
> 
> -Priya
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
