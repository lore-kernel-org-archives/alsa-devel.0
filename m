From: Tony Senerchia <asenerchia@gmail.com>
Subject: SB Live! 24-bit
Date: Tue, 14 Dec 2004 18:15:24 +0100
Message-ID: <ea64723604121409157e09503e@mail.gmail.com>
Reply-To: Tony Senerchia <asenerchia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

First, thanks for having built a driver for this card! I can finally
hear something!

Second, what I hear is not what it should be. I don't know what to
give as a bug report, but I installed the alsa-cvs and it used the
ca0106 (is that right?) for the card. The sound works, but it is more
than 1x when played in XMMS. I used XMMS because it gave me the most
options for configuration of the alsa driver.

The device hw(0;1) seemed to work the best, the others (up to hw(0;3)
I think) seemed to only give output to one speaker or not at all. I
don't think the bass is getting anything (I can't hear anything).

Is it possible to get some sort of configuration support for some of
the options on this card (like how many speakers to use)?

Really, thanks a lot for what you've done already!

Patiently yours,

Tony Senerchia


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
