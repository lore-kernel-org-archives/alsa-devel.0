From: Ludwig Schwardt <schwardt@sun.ac.za>
Subject: Terratec Phase 88 support?
Date: Wed, 11 Feb 2004 11:28:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4029F5A5.6040902@sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

The Terratec EWS88MT is a very affordable multichannel soundcard with 
ALSA support that has unfortunately been discontinued, as I understand 
from their distributors. It is replaced by the Phase 88, which appears 
to be a very similar card and might in fact just be a rebranded EWS88MT.

Someone replaced the PCI ID in the EWS ALSA driver with that of the 
Phase 88, and was able to play back sounds via ALSA. Recording and 
mixing seems to be a problem, though.

I plan on buying some of these cards in the near future, but I need 
recording functionality using JACK. Without an ALSA driver, I therefore 
can't use it.

Is there anyone working on a driver for this card? Could the people who 
wrote the EWS driver maybe look into this?

If this driver doesn't materialize soon, are there any alternative 
affordable multichannel soundcards (meaning 8-channel cards costing 
about $400) I can consider?

Thanks very much in advance,

Ludwig Schwardt



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
