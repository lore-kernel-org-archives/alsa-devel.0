From: Dsant <liste@votreservice.com>
Subject: which fonction ?
Date: Sun, 6 Apr 2008 16:32:41 -0400
Message-ID: <200804061632.41955.liste@votreservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27])
	by alsa0.perex.cz (Postfix) with ESMTP id 8815124585
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Apr 2008 22:32:41 +0200 (CEST)
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BE2D11AB33C
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Apr 2008 22:32:40 +0200 (CEST)
Received: from vai69-1-82-67-46-45.fbx.proxad.net
	(vai69-1-82-67-46-45.fbx.proxad.net [82.67.46.45])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A85451AB2BE
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Apr 2008 22:32:40 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I would like to implement this, but I don't know which fonction to use :
LOOP START
	   begin acquire
	   some long stuf... (about 1-2 seconds)
	   copy buffer to ram or into file
LOOP END
Dsant
