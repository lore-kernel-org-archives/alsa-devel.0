From: Robert Liguori <liguorir@enroute-computer.com>
Subject: QtPhone
Date: Sat, 12 Jul 2003 17:28:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F107D7B.9040004@enroute-computer.com>
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I've decided to write a telephone emulation application.

https://sourceforge.net/projects/qtphone/

I have a few questions, that I was hoping you fellow ALSA developers 
could help me with.  Essentially, I'm trying to get the big picture of 
sound communications between sound boards<->modems<->other devices.

1.)  How does ALSA sound drivers interact with modem voice needs.  ( 
I.e. libraries, devices, resources, etc. )

2.)  When designing a  sound widget for an application, whats the best 
way to tap into amplitude and frequency modification?

3.)  I'm curious about the extreme bounds of ALSA drivers.  What are the 
extent of their possibilities,  and where are they limited.

4.)   If someone has to select the top three best linux sound cards for 
linux, utilizing the ALSA driver, what would they be?

5.)   Could someone recommend a PCI V.92 voice capable modem that would 
work best with an ALSA sound card.  ( Or is there no inter-dependency? )

Thanks,

Robert Liguori.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
