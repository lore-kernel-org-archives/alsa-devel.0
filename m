From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: cs46xx: alsa-docs note
Date: Thu, 27 Feb 2003 02:59:15 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E5D0073.3020903@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>, mail@richardstevens.de
List-Id: alsa-devel@alsa-project.org

Sorry I must have missed sending this here.

The following has been submitted as a note for the documentation of cs46xx.

sender: 	mail_NoSPaM_@richard_NOSPAM_stevens.de
date:   	Friday, 03 January 2003

Terratec DMX XFire 1024:

The DMX XFire 1024 doesn't get initialized correctly the first time
the alsa modules are loaded. Sound is heavily distorted. Usually
reloading the modules solves this problem. One can do that
autmatically by loading, unloading and reloading the modules in
the bootscripts.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
