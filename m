From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: modules.conf in the alsa docs pages
Date: Tue, 20 Aug 2002 13:40:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820134024.430b48b2.sjt@star.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I just noticed when checking for something in the "install"
documentation on the ALSA page that the alias in the template
modules.conf is not being filled in any more; i.e. it reads:
       alias snd-card-0 snd-
for many cards (not all -- interwave seems to work, but ice1712
doesn't), I'm sure that it was OK last time I checked [a week or so
ago].

James

-- 
+------------------------+-------------------------------+---------+
| James Tappin           | School of Physics & Astronomy |  O__    |
| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
+--------------------------------------------------------+---------+


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
