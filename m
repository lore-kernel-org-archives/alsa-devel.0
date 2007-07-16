From: albox@free.fr
Subject: Re: No sound on Medion laptop (intel 82801G)
Date: Mon, 16 Jul 2007 06:44:45 +0200
Message-ID: <1184561085.469af7bd4a727@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BA5024355
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 05:44:46 +0200 (CEST)
Received: from imp3-g19.free.fr (imp3-g19.free.fr [212.27.42.3])
	by smtp5-g19.free.fr (Postfix) with ESMTP id CE36F4446F
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 05:44:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have added a note for this bug on :
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3160

I'm not really sure but it seems that the file /etc/modprobe.d/alsa-base is not
loaded.
http://ubuntuforums.org/showthread.php?p=3026300#post3026300

Any idea ?

Thanks
