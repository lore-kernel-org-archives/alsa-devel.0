From: Mark Hills <mark@pogo.org.uk>
Subject: snd-usb-caiaq: Locking bug fixes
Date: Sat, 24 Oct 2009 12:58:45 +0100 (BST)
Message-ID: <alpine.NEB.2.01.0910241233570.26979@jrf.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 0578724536
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Oct 2009 13:59:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi, I'll follow up this mail with 3 revised patches for inclusion. 
They fix a significant bug; Daniel has ack'd them and asked that they go 
into -rc if possible.

Thanks,

-- 
Mark
