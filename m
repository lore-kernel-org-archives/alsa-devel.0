From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: ASoC talk at CELF conference
Date: Wed, 05 Apr 2006 13:42:36 +0100
Message-ID: <1144240956.25035.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'd like to announce that I'm presenting a talk on ASoC at the CELF
conference in San Jose on the 11th - 12th April.

The conference website is here:-

http://www.celinux.org/elc2006/index.html

My talk is titled "Enhancing ALSA for portable devices" and discusses
new features in ASoC that will make ALSA better for portable and
cellular devices. 

Topics include:

 o Dynamic Audio Power Management (DAPM)
 o Digital Audio Interface (DAI) matching and optimising for low power.
 o Pop and click reduction
 o Dealing with external audio events (i.e. jack insertion)
 o Usage Scenario setting.

There is source code at http://www.rpsys.net/openzaurus/patches/alsa/
for the first three topics. The last two topics are still in the
planning stage and I'll be posting an RFC to the list shortly after my
return.

I'm hoping to submit ASoC to alsa-kernel at the end of April / start of
May. It's relatively stable now and is in need of some further
documentation before submission. 


Liam




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
