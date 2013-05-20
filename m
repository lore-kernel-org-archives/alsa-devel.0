From: "Zhang wei" <zhangwei@vimicro.com>
Subject: what is the difference between
	SNDRV_PCM_IOCTL_WRITEN_FRAMES and SNDRV_PCM_IOCTL_WRITEI_FRAMES
Date: Mon, 20 May 2013 15:14:01 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A0852101C@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (unknown [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B712608D0
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 09:14:08 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I know the format likes below when use SNDRV_PCM_IOCTL_WRITEI_FRAMES
<http://lxr.free-electrons.com/ident?i=SNDRV_PCM_IOCTL_WRITEN_FRAMES> 
L+R+L+R+L+R...
L:a frame left channel data.
R:a frame right channel data.
Right?
 
But what is the kind of format when use SNDRV_PCM_IOCTL_WRITEN_FRAMES
<http://lxr.free-electrons.com/ident?i=SNDRV_PCM_IOCTL_WRITEN_FRAMES> ?
 
Thank you:-)
Br
zw
 
